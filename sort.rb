# Sort モジュール（クイックソートとマージソートの処理で構成）
module Sort

# quick_sort メソッド
# 引数 (bottom, top, data) = （配列のいちばん最初の値、最後の値、ソートする配列）
def self.quick_sort(bottom, top, data)

  if bottom >= top
    return
  end

  lower = bottom
  upper = top

  temp = 0.0
  div = 0.0

  #先頭の値を「適当な値 = div」とする（配列のいちばん最初の成分の値）
  div = data[bottom]

  # lower（下から上がっていく値）と upper (上から下がっていく値）が交わるまで繰り返し
  while lower < upper do

    while (lower < upper) && (data[lower] < div) do
      lower += 1
    end

    while (lower < upper) && (data[upper] > div) do
      upper -= 1

    end

    if lower < upper
      temp = data[lower]
      data[lower] = data[upper]
      data[upper] = temp
    else
      break
    end

  end

  #前半、後半とも再びソート
    self.quick_sort(bottom, (upper - 1), data)
    self.quick_sort( (upper + 1), top, data)

end
# quick_sort メソッド終わり

#merge_sort メソッド（マージソート）
#引数 (n, x) = (配列の要素の数、ソートする配列）
def self.merge_sort(n, x)

  i, j, k, m = 0, 0, 0, 0

  if n <= 1
    return
  end

  m = n / 2

  buffer = x[m..(n - 1)]

  # ブロックを前半と後半に分けてソート（再帰呼び出し）
  merge_sort(m, x)
  merge_sort(n - m, buffer)

  # x の前半を x の後半にコピー
  x[(n - m)..(n - 1)] = x[0..(m - 1)]

  j = n - m

  # buffer（ブロックの後半をソートした配列）とｘの後半とで比較して、小さい方をｘの前半に入れる
  while i < (n - m) && j < n do
    if buffer[i] <= x[j]
      x[k] = buffer[i]
      k += 1
      i += 1
    else
      x[k] = x[j]
      k += 1
      j += 1
    end
  end

  while i < (n - m) do
    x[k] = buffer [i]
    k += 1
    i += 1
  end

  #p x

end
# merge_sort メソッド終わり

end
#Sort モジュール終わり

#配列を生成し、ソートする（main 処理）

#配列の大きさを入力
puts "Number of index"
a = gets.to_i
N = a

# 要素数Ｎの配列を生成
sort_array = Array.new(N)

puts "Before sort"
# １０００以下の乱数を生成し、sort_array配列に格納
for i in 0..(N - 1) do

  sort_array[i] = Random.rand(1000)
  print sort_array[i].to_s + ", "
end

puts "\n"

puts "Sort is started"
# merge_sort メソッド呼び出し
Sort.merge_sort(N, sort_array)

puts "Sort ended"
for i in 0..(N - 1) do
  print sort_array[i].to_s + ", "
end

puts "\n"