Facter.add(:is_puppetmaster) do 
  setcode do 
    Facter.value(:fqdn).include? 'server'
  end
end
