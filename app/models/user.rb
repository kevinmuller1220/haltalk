class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Rails.application.routes.url_helpers 

  validates_presence_of :username, :password
  validates_uniqueness_of :username

  #TODO: make username unique

  has_many :posts

  field :username
  field :password
  field :bio
  field :post_count, type: Integer
  field :real_name

  def as_json(opts)
    {
      _links: {
        self: { href: user_path(self) },
        curies: [{
          name: 'ht',
          href: 'http://haltalk.herokuapp.com/rels/{rel}',
          templated: true
        },{
          name: 'bla',
          href: 'http://haltalk.herokuapp.com/rels/{rel}',
          templated: true
        }],
        'ht:posts' => { href: user_posts_path(self) }
      }
    }.merge(super(opts).slice('username', 'bio', 'postcount', 'real_name'))
  end

  def to_param
    username
  end

  def self.find_by_username(name)
    where(username: name).first
  end
end
