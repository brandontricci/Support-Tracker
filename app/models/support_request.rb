class SupportRequest < ActiveRecord::Base


  validates_presence_of :name, :email

  DEPARTMENT_SALES     = "sales".freeze
  DEPARTMENT_MARKETING = "marketing".freeze
  DEPARTMENT_TECHNICAL = "technical".freeze

  DEPARTMENTS = [ DEPARTMENT_SALES,
                  DEPARTMENT_MARKETING,
                  DEPARTMENT_TECHNICAL]


  def self.search_by(search_term)
    where(["LOWER(name)    LIKE :search_term OR 
            LOWER(email)   LIKE :search_term OR
            LOWER(message) LIKE :search_term", 
            {search_term: "%#{search_term.downcase}%"}]
          )
  end

end