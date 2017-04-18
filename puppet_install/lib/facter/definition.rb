Facter.add(:definition) do
  setcode do
    Facter.value(:hostname) == 'master'
  end
end
