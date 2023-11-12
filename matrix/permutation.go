package matrix

type PermNumbers struct {
	List         []int
	NReplacement int
}

func exclude(numbers []int, n int) []int {
	var r []int
	for _, n2 := range numbers {
		if n2 != n {
			r = append(r, n2)
		}
	}
	return r
}

func GenPermGroup(numbers []int) []PermNumbers {
	if len(numbers) == 2 {
		return []PermNumbers{
			PermNumbers{
				List:         []int{numbers[0], numbers[1]},
				NReplacement: 0,
			},
			PermNumbers{
				List:         []int{numbers[1], numbers[0]},
				NReplacement: 1,
			},
		}
	}
	if len(numbers) < 2 {
		panic("Unexpected input")
	}
	var r []PermNumbers
	var replacement int
	for _, n := range numbers {
		numbers2 := exclude(numbers, n)
		prmNumbers := GenPermGroup(numbers2)
		for _, nums := range prmNumbers {
			list := append([]int{n}, nums.List...)
			pn := PermNumbers{
				List:         list,
				NReplacement: nums.NReplacement + replacement,
			}
			r = append(r, pn)
		}
		replacement++
	}
	return r
}
