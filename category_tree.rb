
class CatNode
  attr_accessor :name, :left_child, :right_child

  def initialize (name)
    @name = name
    @left_child = nil
    @right_child = nil
  end

  # Recursively finds the node (this parent or a child) that matches the passed name
  def find_node(name)
    if self.name == name
      return self
    end

    # Check the left side
    unless self.left_child.nil?
      left_node = self.left_child.find_node(name)
    end

    if left_node.nil?
      # Check the right side
      unless self.right_child.nil?
        return self.right_child.find_node(name)
      end
    else
      return left_node
    end
  end

  # TODO: Unless I'm missing something, you only can add 2 child categories (L, R) to any given (parent) category
  # Inserts a child node
  def insert_child(name)
    # TODO: Do we need to check like <=> for category name (e.g. alphabetic)
    if self.left_child.nil?
      # Add to the left
      self.left_child = CatNode.new(name)
    elsif self.right_child.nil?
      # Add to the right
      self.right_child = CatNode.new(name)
    else
      # TODO: This seems odd that you don't insert farther down...need to revisit
      # already contains 2 children (L, R)
      raise ArgumentError.new('Parent categories full!')
    end
  end

  # Print this node (pre-order)
  def print_node
    p self.name

    unless self.left_child.nil?
      self.left_child.print_node
    end

    unless self.right_child.nil?
      self.right_child.print_node
    end
  end
end

class CategoryTree
  attr_accessor :root

  # Add a new parent or child category node to the CategoryTree
  def add_category(category_name, parent_name)
    # First check if adding the parent/root node or a child to an existing parent
    if parent_name.nil?
      unless @root.nil?
        raise ArgumentError.new('CategoryTree root already exists!')
      end

      # Add the root node
      @root = CatNode.new(category_name)
    else
      # Get the parent CatNode in the tree
      parent_node = get_node(parent_name)

      if parent_node.nil?
        raise ArgumentError.new("CategoryTree does not contain parent '#{parent_name}'!")
      else
        # Check if this category already exists
        raise ArgumentError.new("Category '#{category_name}' already exists in the tree!") if contains?(category_name)

        # Add child to the parents child list
        parent_node.insert_child(category_name)
      end
    end
  end

  # Returns bool if the CategoryTree contains the passed category name
  def contains?(category_name)
    if @root.find_node(category_name).nil?
      return false
    else
      return true
    end
  end

  # Returns the CatNode with the passed name in the CategoryTree
  def get_node(category_name)
    # Start at the tree root and find the node
    return @root.find_node(category_name)
  end

  # Return the passed parent's children in the CategoryTree
  # TODO: So in this type of tree that means you will only ever return empty [], 1 child, or both children
  def get_children(parent_name)
    children = []

    # First get the parent CatNode
    parent_node = get_node(parent_name)

    # Add children if they exist
    unless parent_node.left_child.nil?
      children << parent_node.left_child.name
    end
    unless parent_node.right_child.nil?
      children << parent_node.right_child.name
    end

    return children
  end

  # Print out the whole CategoryTree (pre-order)
  def print_tree
    puts "\nPrinting CategoryTree..."
    if @root.nil?
      puts 'The tree is EMPTY!'
    else
      @root.print_node
    end
  end
end

c = CategoryTree.new
#c.print_tree
# Populate
c.add_category('A', nil)
#c.print_tree
c.add_category('B', 'A')
#c.print_tree
c.add_category('C', 'A')
#c.print_tree
c.add_category('D', 'B')
#c.print_tree
c.add_category('E', 'B')
c.print_tree


# Invalids
# `insert_child': Parent categories full! (ArgumentError)
#c.add_category('Z', 'A')

# `add_category': Category 'D' already exists in the tree! (ArgumentError)
#c.add_category('D', 'C')

# `add_category': CategoryTree root already exists! (ArgumentError)
#c.add_category('B', nil)

# `add_category': CategoryTree does not contain parent 'G'! (ArgumentError)
#c.add_category('F', 'G')


# Test 0
puts (c.get_children('A') || []).join(',')

# Test 1
puts (c.get_children('B') || []).join(',')

# Test 2
# Prints nothings
puts (c.get_children('C') || []).join(',')