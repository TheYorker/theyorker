class Article < ActiveRecord::Base

  belongs_to :user
  belongs_to :section

  validates :user_id, :presence => true

  def self.pending_articles_for_user(user)
    Article.where(:user_id => user.id, :visibility => 1..2)
  end

  def self.for_review_by_section(section)
    Article.where(:section_id => section.id, :visibility => 2)
  end

  def render
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
    Sanitize.clean(BlueCloth.new(self.body).to_html, Sanitize::Config::RELAXED.merge({:transformers => youtube_transformer})).html_safe
  end

end
