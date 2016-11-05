Fabricator(:adhoc_response_started, from: 'Events::AdhocResponseStarted') do
  response_uuid { SecureRandom.uuid }
  show_secret { SecureRandom.uuid }
  domain_ids ['POS-PQ']
end
