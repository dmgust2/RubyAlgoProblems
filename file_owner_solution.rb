# TestDome File Owner problem

class FileOwnerSolution

  def self.group_by_owners(files)
    owner_group_hash = {}

    # Iterate over each file and add to the owner group hash
    files.each do |file, owner|
      # If the owner doesn't exist create a new array of files
      if owner_group_hash[owner].nil? then owner_group_hash[owner] = [] end

      # Add file to the owner
      owner_group_hash[owner] << file
    end

    return owner_group_hash
  end

end

# Test 1
files_1 = {
    'Input.txt' => 'Randy',
    'Code.py' => 'Stan',
    'Output.txt' => 'Randy'
}
puts FileOwnerSolution.group_by_owners(files_1)

# Test 2
files_2 = {
    'a.txt' => 'Dave',
    'b.py' => 'Stan',
    'b.txt' => 'Dave',
    'c.txt' => 'DAve'
}
puts FileOwnerSolution.group_by_owners(files_2)
