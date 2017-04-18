Facter.add(:is_puppetmaster) do
  setcode do
    Facter.value(:hostname).include? 'puppet-serv'
  end
end
