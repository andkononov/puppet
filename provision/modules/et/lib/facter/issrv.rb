Facter.add(:is_puppetserver) do
  setcode do
    Facter.value(:fqdn) == 'puppet.loc'
  end
end