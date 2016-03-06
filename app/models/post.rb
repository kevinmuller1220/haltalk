class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Rails.application.routes.url_helpers 

  validates_presence_of :content

  field :content
  field :in_reply_to

  def as_json(opts)
    json = {
      _links: {
        self: { href: post_path(self) },
        'ht:author' => { href: user_path(self.user), title: self.user.real_name }
      }
    }

    json[:_links]['ht:in-reply-to'] = { href: in_reply_to } if in_reply_to?

    json.merge(super(opts).slice('content','created_at'))
  end

  belongs_to :user
end
