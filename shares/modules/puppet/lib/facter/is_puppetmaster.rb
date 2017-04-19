Facter.add(:is_pappetmaster) do
  setcode do
    Facter.value(:fqdn).include? 'master'
  end
end
