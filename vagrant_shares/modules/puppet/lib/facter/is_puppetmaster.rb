Facter.add(:is_puppetserver) do
  setcode do
    Facter.value(:fqdn) == "master.kuzniatsou.local"
  end
end