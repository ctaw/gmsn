class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  scope :basic_details, -> { select(:email, :first_name, :last_name, :id, :role_id, :created_at) }
  scope :exclude_self, -> (value) { where(id: value) }

  enum role_id: [:admin, :accounting, :employee]

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def get_role
    case role_id
    when 0
      "Admin"
    when 1 
      "Accounting"
    when 2
      "Employee"
    end
  end

  def full_name
    self.first_name+" "+self.last_name
  end

end
