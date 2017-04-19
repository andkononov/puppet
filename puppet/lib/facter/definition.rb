Facter.add(:definition) do
  setcode do
    Facter.value(:fqdn) == 'server.lab'
  end
end

