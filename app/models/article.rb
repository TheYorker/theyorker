class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :section

  has_many :comments

  validates :user_id, :presence => true

  # article types for users

  def self.draft_for_user(user)
    Article.where(:user_id => user.id, :visibility => 1)
  end
  
  def self.review_for_user(user)
    Article.where(:user_id => user.id, :visibility => 2)
  end
  
  def self.published_for_user(user)
    Article.where(:user_id => user.id, :visibility => 3)
  end

  # article types for sections

  def self.review_for_section(section)
    Article.where(:section_id => section.id, :visibility => 2)
  end
  
  def self.queued_for_section(section)
    Article.where(:section_id => section.id,
                  :visibility => 3).where("publish_at > ?", Time.now)
  end

  def self.published_for_section(section)
    Article.where(:section_id => section.id,
                  :visibility => 3).where("publish_at <= ?", Time.now)
  end

  def self.latest_published_by_section(section, limit=5)
    Article.where(:section_id => section.id,
                  :visibility => 3).where("publish_at <= ?", Time.now).limit(limit)
  end

  def submit_for_review
    self.visibility = 2         # horrible magic number for 'Editorial Review'
    self.save
  end

  def withdraw
    self.visibility = 1
    self.save
  end

  def publish
    self.visibility = 3         # horrible magic number for 'Public'
    self.save
  end

  def withdraw_from_publication
    if self.visibility == 3
      self.visibility = 2
    end
    self.save
  end

  def rank
    self.importance - age_in_days
  end

  def feature_rank
    self.featuredness - age_in_days
  end

  def render
    config = Sanitize::Config::RELAXED
    youtube_transformer = lambda do |env|
      node      = env[:node]
      node_name = env[:node_name]

      # Don't continue if this node is already whitelisted or is not an element.
      return if env[:is_whitelisted] || !node.element?
      
      # Don't continue unless the node is an iframe.
      return unless node_name == 'iframe'
      
      # Verify that the video URL is actually a valid YouTube video URL.
      return unless node['src'] =~ /\Ahttps?:\/\/(?:www\.)?youtube(?:-nocookie)?\.com\//
      
      # We're now certain that this is a YouTube embed, but we still need to run
      # it through a special Sanitize step to ensure that no unwanted elements or
      # attributes that don't belong in a YouTube embed can sneak in.
      Sanitize.clean_node!(node, {
                             :elements => %w[iframe],
                             
                             :attributes => {
                               'iframe'  => %w[allowfullscreen frameborder height src width]
                             }
                           })
      
      # Now that we're sure that this is a valid YouTube embed and that there are
      # no unwanted elements or attributes hidden inside it, we can tell Sanitize
      # to whitelist the current node.
      {:node_whitelist => [node]}
    end

    config[:transformers] = [youtube_transformer]
    config[:elements] += ['div']
    config[:attributes][:all] += ['class']

    html = Sanitize.clean(BlueCloth.new(self.body).to_html, config)
    # increase heading levels of markdown output by 2
    html.gsub(/<(\/?)h([0-7])>/) {"<#$1h#{$2.to_i+2}>"}.html_safe
  end

  private

  def age_in_days
    (Time.now - self.publish_at) / 1.day
  end

end
