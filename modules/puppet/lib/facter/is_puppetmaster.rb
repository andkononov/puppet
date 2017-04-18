Facter.add(:is_puppetmaster) do
  setcode do
    Facter.value(:hostname) == 'puppet'
  end
end 
