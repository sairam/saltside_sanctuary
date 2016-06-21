class Bird
  include Mongoid::Document

  field :name, type: String
  field :family, type: String
  field :continents, type: Array, default: []
  field :added, type: String, default: -> { Time.now.utc.strftime('%Y-%m-%d') }
  field :visible, type: Boolean, default: false

  validates_presence_of :name, :family
  validates :continents, length: { minimum: 1 }
  # Testing for boolean is not required since mongoid takes care of conversion of strings
  # validates :visible, inclusion: { in: [ true, false ] }
  validate :date_added, :continent_data

  scope :visible, -> { where(visible: true) }

  def serializable_hash(options = nil)
    h = super(options)
    if(h.has_key?('_id'))
      h['id'] = h.delete('_id').to_s
    end
    h
  end

  private

  def date_added
    Date.parse(added)
  rescue
    errors.add(:continents, "is not a valid date")
  end
  def continent_data
    if continents.class == Array
      continents.each do |x|
        errors.add(:continents, "#{x} is not a string") unless x.class == String
      end
    else
      errors.add(:continents, "is not an array")
    end
  end

end
