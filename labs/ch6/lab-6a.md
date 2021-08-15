### Understanding the PHONY Directive (Lab 6a)

#### Create a Small Makefile

Create a small two-line Makefile. Be sure to use a tab character
to indent the second line.

    franklin:~$ cat Makefile
    code:
            echo "this is a test"

#### Test the Makefile

Test the Makefile by running the ``make'' command. Notice that you can
type "make" or ``make code'' and get the same result.

    franklin:~$ make code
    make: 'code' is up to date.
    franklin:~$ make 
    make: 'code' is up to date.

#### Test Again with PHONY

Now edit the Makefile to include the PHONY directive. Be mindful of the 
leading dot character.

    .PHONY: code
    code:
           echo "this is a test"

Try running make again.

   franklin:~$ make code
   echo "this is a test"
   this is a test
 
Note that the output occurs twice. To supress the extra output, you can
prepend the command with an amperand character like so:

    .PHONY: code
    code:
            @echo "this is a test"

Now try running one final time.

   franklin:~$ make code
   this is a test

Now we get the desired result without the printing of the command
by make.

