Facter.add(:puppet_version) do
  setcode do
    Facter::Core::Execution.exec('puppet -V')
  end
end