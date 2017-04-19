Facter.add(:definition) do
  setcode do
    Facter.value(:hostname) == 'server'
  end
end
