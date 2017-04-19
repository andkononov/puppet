Facter.add(:definition) do
  setcode do
    Facter.value(:hostname) == 'server.lab'
  end
end
