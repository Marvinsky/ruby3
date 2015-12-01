class Post < ActiveRecord::Base
  belongs_to :user, dependent: :destroy
  has_many :attachments
  has_many :payments
  validates :title, presence: true, uniqueness: true
  before_save :default_values

  include Picturable
  include PublicActivity::Model
  tracked owner: Proc.new{|controller, model| controller.current_user}


  def default_values
  	self.cost ||= 0 #only when cost is nil
  end


end