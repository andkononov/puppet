Facter.add(:is_puppetmaster) do
setcode do
Facter.value(:hostname) == 'puppetserver'
end
end


