Facter.add(:is_puppetmaster) do
  setcode do
  Facter.value(:fqdn) == 'master.epbyminw2695.minsk.epam.com'
  end
end