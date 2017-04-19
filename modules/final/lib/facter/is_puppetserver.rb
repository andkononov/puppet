Facter.add(:is_puppetserver) do
  setcode do
  Facter.value(:fqdn) == 'srv.minsk.epam.com'
  end
end
