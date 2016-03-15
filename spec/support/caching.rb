def enable_caching
  Rails.application.config.cache_store = :memory_store
  Rails.cache.clear
end

def disable_caching
  Rails.application.config.cache_store = :null_store
end
