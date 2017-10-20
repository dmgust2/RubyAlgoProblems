# TestDome Path problem

class PathSolution
  def initialize(path)
    @current_path = path
  end

  def current_path
    @current_path
  end

  def cd(new_path)
    # First see if its a relative path
    if new_path.start_with?('..')
      # First parse the current_path into an array/stack
      current_path_stack = []
      @current_path.split('/').each {| dir | current_path_stack << dir }
      #p current_path_stack

      # Now parse the new path and update the stack accordingly
      new_path.split('/').each do | new_dir |
        if new_dir == '..'
          # Pop/remove the last element (dir) from the stack
          current_path_stack.pop(1)
        else
          # Simply add the dir to the current path
          current_path_stack << new_dir
        end
      end

      # Now reconstitute the full new path from the stack
      #p current_path_stack
      new_path_temp = ''
      current_path_stack.each do | dir |
        unless dir.empty?
          new_path_temp = new_path_temp + '/' + dir
        end
      end
      @current_path = new_path_temp
    else
      if new_path.start_with?('/')
        # Absolute path, so simply set current_path
        @current_path = new_path
      else
        # Append child dirs to current path
        @current_path = @current_path + '/' + new_path
      end
    end
  end

end

# Test 1
path1 = PathSolution.new('/a/b/c/d')
path1.cd('../x')
puts 'Test 1: ' + path1.current_path

# Test 2
path2 = PathSolution.new('/')
path2.cd('../x')
puts 'Test 2: ' + path2.current_path

# Test 3
path3 = PathSolution.new('/a/b/c/d')
path3.cd('/')
puts 'Test 3: ' + path3.current_path

# Test 4
path4 = PathSolution.new('/a/b/c/d')
path4.cd('/x')
puts 'Test 4: ' + path4.current_path

# Test 5
path5 = PathSolution.new('/a/b/c/d')
path5.cd('x')
puts 'Test 5: ' + path5.current_path

# Test 6
path6 = PathSolution.new('/a/b/c/d')
path6.cd('x/y/z')
puts 'Test 6: ' + path6.current_path

# Test 7
path7 = PathSolution.new('/a/b/c/d')
path7.cd('../../../x/erreer/erreer')
puts 'Test 7: ' + path7.current_path
