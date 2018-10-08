

# reference .    http://www.bahmanm.com/blogs/command-line-options-how-to-parse-in-bash-using-getopt

#!/user/bin/env bash

# “a” and “arga” have optional arguments with default values.
# “b” and “argb” have no arguments, acting as sort of a flag.
# “c” and “argc” have required arguments.

# set an initial value for the flag
ARG_B=0

# read the options
TEMP=`getopt -o a::bc: --long arga::,argb,argc: -n 'test.sh' -- "$@"`
eval set -- "$TEMP"

# extract options and their arguments into variables.
while true ; do
    case "$1" in
        -a|--arga)
            case "$2" in
                "") ARG_A='some default value' ; shift 2 ;;
                *) ARG_A=$2 ; shift 2 ;;
            esac ;;
        -b|--argb) ARG_B=1 ; shift ;;
        -c|--argc)
            case "$2" in
                "") shift 2 ;;
                *) ARG_C=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

# do something with the variables -- in this case the lamest possible one :-)
echo "ARG_A = $ARG_A"
echo "ARG_B = $ARG_B"
echo "ARG_C = $ARG_C"
 Short option
A short option is composed of a - (dash character) followed by a single letter, for example -a or -A, and it may expect an argument.

Without argument like -a or -H
With argument
With required arguments like -a bahman or -Hreports
With optional arguments like -abahman. Note that there can't be any spaces between the option (-a) and the argument (bahman).
Long option
A long option is composed of a -- (two consequent dash characters) followed by any number of alpha-numeric characters (like --option-a) and it may expect an argument.

Without argument like --option-a or --more-2-go
With arguments
With required arguments like --file-to-process reports or --package-name-prefix='com.bahmanm'
With optional arguments like --package-name-prefix='com.bahmanm'. Note that the argument can be passed only using =.
 

What is an “option string”?
The only way to tell getopt about the options it should expect is by building an option string. Normally you would pass 2 option strings to getopt, one for short options and the other for long options.

Option string for short options
It is passed to getopt using -o option and follows the rules below.

Rules:

Each single character stands for an option.
A : (colon character) tells that the option has a required argument.
A :: (two consequent colon character) tells that the option has an optional argument.
Example:

The option string f:gh::i: means that the are four options. f has a required argument, g has no argument, h has an optional argument and i has a required argument.

Option string for long options
It is passed to getopt using --long option and follows the rules below.

Rules:

Options are separated by , (comma character).
A : (colon character) tells that the option has a required argument.
A :: (two consequent colon character) tells that the option has an optional argument.
Example:

The options string foo,bar::,baz:,foobar means that there are four options. foo has no argument, bar has an optional argument, baz has a required argument and foobar has no argument.
