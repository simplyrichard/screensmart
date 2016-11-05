# When the user clicks "fill out directly", an adhoc response is started.
class StartAdhocResponse < ActiveInteraction::Base
  array :domain_ids

  validates :domain_ids, presence: true
  validate :validate_domain_ids_defined_by_r_package

  def execute
    Events::AdhocResponseStarted.create! domain_ids: domain_ids,
                                         response_uuid: SecureRandom.uuid,
                                         show_secret: SecureRandom.uuid
  end

  private

  def validate_domain_ids_defined_by_r_package
    return if domain_ids.empty?
    domain_ids_not_found = domain_ids - RPackage.domain_ids
    domain_ids_not_found.each do |domain_not_found|
      errors.add(:domain_ids, "#{domain_not_found} is not a valid domain")
    end
  end
end
