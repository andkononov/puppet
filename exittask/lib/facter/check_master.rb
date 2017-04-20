Facter.add(:is_master) do
  setcode do
    hostname = Facter.value(:hostname)
    hostname.include?('master') ? true: false
  end
end