package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
)

func readLines(path string) ([]string, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []string
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		lines = append(lines, scanner.Text())
	}
	return lines, scanner.Err()
}

func check(i int, section []string) string {
	if i < len(section) {
		return section[i]
	}
	return ""
}

func main() {
	var (
		header, errh   = readLines("parts/header.tex")
		section1, err1 = readLines("parts/section1.tex")
		section2, err2 = readLines("parts/section2.tex")
	)
	if errh != nil {
		log.Fatal(errh)
		return
	}
	if err1 == nil {
		if err2 != nil {
			log.Fatal(err2)
			return
		}
		for _, line := range header {
			fmt.Println(line)
		}
		for i := range section1 {
			if i == 45 {
				break
			}
			var (
				first  = check(i, section1)
				second = check(i, section2)
			)
			fmt.Printf("        %s & %s \\\\\n", first, second)
		}
		fmt.Printf("    \\end{tabular}\\\\\n")
		if len(section1) > 45 {
			for i := range section1[44:] {
				fmt.Printf("    %s\\\\\n", section1[i+44])
			}
		}
		fmt.Printf("    \\gitlinkc{muhammadmuzzammil1998/Resume}{\\tiny{Generated on \\today}}\n")
		fmt.Printf("\\end{document}\n")
		return
	}
	log.Fatal(err1)
	return
}
