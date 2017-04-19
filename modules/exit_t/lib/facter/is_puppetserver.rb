Facter.add(:is_puppetserver) do
  setcode do
  Facter.value(:fqdn) == 'puppet-srv.epam.com'
  end
end
