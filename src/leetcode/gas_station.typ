#import "../book.typ": book-page
#import "init.typ": leetcode-page

#show: book-page.with(title: "gas_station")
#show: leetcode-page


= 加油站

见#link("https://leetcode.cn/problems/gas-station/")[LeetCode 134.加油站]

#box()[
在一条环路上有 `n` 个加油站，其中第 `i` 个加油站有汽油 `gas[i]` 升。

你有一辆油箱容量无限的的汽车，从第 `i` 个加油站开往第 `i+1` 个加油站需要消耗汽油 `cost[i]` 升。你从
其中的一个加油站出发，开始时油箱为空。

给定两个整数数组 `gas` 和 `cost` ，如果你可以按顺序绕环路行驶一周，则返回出发时加油站的编号，否则返
回 `-1` 。如果存在解，则 *保证* 它是 *唯一* 的。

*示例 1:*

```
输入: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
输出: 3
解释:
从 3 号加油站(索引为 3 处)出发，可获得 4 升汽油。此时油箱有 = 0 + 4 = 4 升汽油
开往 4 号加油站，此时油箱有 4 - 1 + 5 = 8 升汽油
开往 0 号加油站，此时油箱有 8 - 2 + 1 = 7 升汽油
开往 1 号加油站，此时油箱有 7 - 3 + 2 = 6 升汽油
开往 2 号加油站，此时油箱有 6 - 4 + 3 = 5 升汽油
开往 3 号加油站，你需要消耗 5 升汽油，正好足够你返回到 3 号加油站。
因此，3 可为起始索引。
```

*示例 2:*

```
输入: gas = [2,3,4], cost = [3,4,3]
输出: -1
解释:
你不能从 0 号或 1 号加油站出发，因为没有足够的汽油可以让你行驶到下一个加油站。
我们从 2 号加油站出发，可以获得 4 升汽油。 此时油箱有 = 0 + 4 = 4 升汽油
开往 0 号加油站，此时油箱有 4 - 3 + 2 = 3 升汽油
开往 1 号加油站，此时油箱有 3 - 3 + 3 = 3 升汽油
你无法返回 2 号加油站，因为返程需要消耗 4 升汽油，但是你的油箱只有 3 升汽油。
因此，无论怎样，你都不可能绕环路行驶一周。
```

*提示:*

- `gas.length == n`
- `cost.length == n`
- `1 <= n <= 10⁵`
- `0 <= gas[i], cost[i] <= 10⁴`
]

朴素做法是遍历每个起始地，然后根据每个起始地往后遍历判断是否能够走完全程，
遍历起始地的时间复杂度是$O(n)$，根据不同起始地还要进行遍历判断，最坏情况下也会
达到$O(n)$，所以总的复杂度接近$O(n^2)$

考虑到实际上做了很多重复的计算，比如
#figure(supplement: [图])[
```
gas  = [0, 0, 0, 0, 0, 0, 1, 2]
cost = [0, 0, 0, 0, 0, 0, 2, 1]
```
] <example>
`start = 0`时最大可以达到`6`，`0-5`是计算过的，按照朴素算法，接下来要判断`start = 1`
的情况，容易知道最大还是到`6`，`1-5`就重复计算了。

因此在遍历到`6`发现无法往后继续走时，直接将`start`记为下一个地点即可，因为前面这一段路的
净油量为负数，中间不可能有满足条件的起点，这样一来就减少了重复计算。一直到`start = n`时可以行驶
到最后一个地点，这时候判断剩余的油量是否足以抵消前面的负油量，若可以则说明该起点可以行驶一圈，若不行，
则没有满足条件的起点。
