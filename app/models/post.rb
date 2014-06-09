class Post < ActiveRecord::Base
  validates :title, presence: true

  has_attached_file :picture, 
  styles: { medium: '300x300>'},
  storage: :s3,
  s3_credentials: {
  	bucket: 'instaham',
  	access_key_id: Rails.application.secrets.s3_access_key,
  	secret_access_key: Rails.application.secrets.s3_secret_key
  }
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  belongs_to :user
  has_and_belongs_to_many :tags
  has_many :likes

  def tag_names
    ''
  end

  def tag_names=(tag_names)
    return if tag_names.blank?
    extract_tags(tag_names).uniq.each do |tag_name|
      formatted_name = '#' + tag_name
      
      tag = Tag.find_or_create_by(name: formatted_name)
      tags << tag
    end
  end

  private

  def extract_tags(tag_names)
    tag_names.split(/[\s,]+/).map do |tag_name|
      if tag_name.start_with?('#')
        tag_name[1..-1]
      else
        tag_name
      end
    end
  end

end
