# coding: utf-8
#-----------------------------------------------#
#２分探索木アルゴリズム


# Binary_Tree_Node クラス（２分木の１つのノード）
class Binary_Tree_Node
  # インスタンス変数は参照と更新可能
  attr_accessor :value, :left, :right

  # コンストラクタ
  def initialize(num = 0)
    @value = num
    @left  = nil
    @right = nil
  end

  # 節の挿入（num が親ノードより小さければ左、大きければ右, 同じなら何もしない）
  def insert_node!(num = 0)
    if @value == num
      # 何もしない
    else
      if num < @value
        if @left.nil?
          @left = Binary_Tree_Node.new(num)
        else
          @left.insert_node!(num)
        end
      else
        if @right.nil?
          @right = Binary_Tree_Node.new(num)
        else
          @right.insert_node!(num)
        end
      end
    end
  end

  # 探している値を持つ節を見つける
  def find_value(num)
    ans = nil
    if @value == num
      ans = self
    elsif num < @value
      ans = @left.find_value(num) if @left
    elsif @value < num
      ans = @right.find_value(num) if @right
    end
    ans
  end

  # node 以下の最小値の節を探す
  def serach_min(node)
    node = node.left while node.left
    node
  end

  # node 以下の最小値の節を削除する
  def delete_min!(node)
    return node.right unless node.left
    node.left = delete_min!(node.left)
    node
  end

  # node 以下の 値が num の節を削除
  def delete_tree!(node, num)
    if node
      if num == node.value
        if node.left.nil?
          return node.right
        elsif node.right.nil?
          return node.left
        else
          min_node   = serach_min(node.right)
          node.value = min_node.value
          node.right = delete_min!(node.right)
        end
      elsif num < node.value
        node.left = delete_tree!(node.left, num)
      else
        node.right = delete_tree!(node.right, num)
      end
    end
    node
  end

  # 木の状態を出力する
  def print_tree(depth = 0)
    @left.print_tree(depth + 1) if @left
    puts "#{'   ' * depth}#{@value}"
    @right.print_tree(depth + 1) if @right
  end
end

#-----------------------------------------------#
# メイン処理(情報を入力し、木を操作する）
tree_root = Binary_Tree_Node.new

puts 'Start making tree.'
10.times do
  random_value = Random.rand(100)
  tree_root.insert_node!(random_value)
end

puts 'Number of Trial.'
action_count = gets.to_i
# 以下の処理を最大でｎ回だけ繰り返す。
action_count.times do
  puts 'Select Control. (a:add, s:search, d:delete, p:print, q:end)'
  case gets.strip.downcase
  when 'a'
    puts 'Put number.'
    num = gets.to_i
    tree_root.insert_node!(num)
  when 's'
    puts 'Put the number to find.'
    num = gets.to_i
    if tree_root.find_value(num)
      puts "The number #{num} is found."
    else
      puts "The number #{num} is not found."
    end
  when 'd'
    puts 'Put the number to delete.'
    num = gets.to_i
    if num == 0
      puts 'The tree_root can not delete.'
    elsif tree_root.find_value(num).nil?
      puts "The number #{num} couldn't be found."
    else
      tree_root.delete_tree!(tree_root, num)
      puts "The number #{num} is deleted."
    end
  when 'p'
    tree_root.print_tree
  when 'q'
    break # 終了
  end
end