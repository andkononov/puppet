Facter.add(:is_pappetmaster) do
  setcode do
    Facter.value(:fqdn).include? 'server'
  end
end

