package cmd

import (
	"fmt"
	"github.com/honlyc/openim-cmdline/cmd/internal/proto"
	"github.com/spf13/cobra"
	"os"
)

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "openim",
	Short: "openim is an efficiency tool for convenient openim service development",
	Long: `openim is an efficiency tool for convenient openim service development.

Try using trpc framework + openim tool to write your next openim service!
`,
	SilenceErrors: true,
	SilenceUsage:  true,
}

func init() {
	rootCmd.AddCommand(proto.CmdProto)
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Printf(`Execution err:
	%+v
`, err)
		os.Exit(1) // Exist with non-zero errcode to indicate failure.
	}
}
