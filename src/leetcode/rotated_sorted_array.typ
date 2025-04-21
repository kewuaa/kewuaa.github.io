#import "../book.typ": book-page
#import "init.typ": leetcode-page

#show: book-page.with(title: "rotated_sorted_array")
#show: leetcode-page

= 搜索无重复数字的螺旋数组

见#link("https://leetcode.cn/problems/search-in-rotated-sorted-array/description/")[Leetcode 33.搜索旋转排序数组]

#box[
整数数组 `nums` 按升序排列，数组中的值 *互不相同* 。

在传递给函数之前， `nums` 在预先未知的某个下标 `k`（ `0 <= k < nums.length`）上进行了 *旋转*，使数
组变为 `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]`（下标 *从 0 开始* 
计数）。例如， `[0,1,2,4,5,6,7]` 在下标 `3` 处经旋转后可能变为 `[4,5,6,7,0,1,2]` 。

给你 *旋转后* 的数组 `nums` 和一个整数 `target` ，如果 `nums` 中存在这个目标值 `target` ，则返回它
的下标，否则返回 `-1` 。

你必须设计一个时间复杂度为 `O(log n)` 的算法解决此问题。

*示例 1：*

```
输入：nums = [4,5,6,7,0,1,2], target = 0
输出：4
```

*示例 2：*

```
输入：nums = [4,5,6,7,0,1,2], target = 3
输出：-1
```

*示例 3：*

```
输入：nums = [1], target = 0
输出：-1
```

*提示：*

- `1 <= nums.length <= 5000`
- `-10⁴ <= nums[i] <= 10⁴`
- `nums` 中的每个值都 *独一无二*
- 题目数据保证 `nums` 在预先未知的某个下标上进行了旋转
- `-10⁴ <= target <= 10⁴`
]

要求 `O(log n)` 且是搜索题，第一时间想到二分法。

二分法要求数组有序，因为二分后仍然有序，因此可以通过首尾元素判断`target`是否在其中。
而实际上螺旋数组二分之后的两部分也总有一个部分是有序的，如`center`大于`left`则左半
部分有序，反之右半边有序，因此也可以判断`target`是否在有序的部分中，否则则存在另
一部分中。

= 有搜索有重复数字的螺旋数组

见#link("https://leetcode.cn/problems/search-in-rotated-sorted-array-ii/")[Leetcode 81.搜索旋转排序数组 II]

#box[
已知存在一个按非降序排列的整数数组 `nums` ，数组中的值不必互不相同。

在传递给函数之前， `nums` 在预先未知的某个下标 `k`（ `0 <= k < nums.length`）上进行了 *旋转*，使数
组变为 `[nums[k], nums[k+1], ..., nums[n-1], nums[0], nums[1], ..., nums[k-1]]`（下标 *从 0 开始*
计数）。例如， `[0,1,2,4,4,4,5,6,6,7]` 在下标 `5` 处经旋转后可能变为 `[4,5,6,6,7,0,1,2,4,4]` 。

给你 *旋转后* 的数组 `nums` 和一个整数 `target` ，请你编写一个函数来判断给定的目标值是否存在于数组
中。如果 `nums` 中存在这个目标值 `target` ，则返回 `true` ，否则返回 `false` 。

你必须尽可能减少整个操作步骤。

*示例 1：*

```
输入：nums = [2,5,6,0,0,1,2], target = 0
输出：true
```

*示例 2：*

```
输入：nums = [2,5,6,0,0,1,2], target = 3
输出：false
```

*提示：*

- `1 <= nums.length <= 5000`
- `-10⁴ <= nums[i] <= 10⁴`
- 题目数据保证 `nums` 在预先未知的某个下标上进行了旋转
- `-10⁴ <= target <= 10⁴`
]

相比无重复数字的螺旋数组，区别在于可能出现`left`,`center`,`right`均相等的情况，此时只能将`left`和`right`
均向中间移动，即`left++`，`right--`。因此复杂度可能恶化至`O(n)`。
