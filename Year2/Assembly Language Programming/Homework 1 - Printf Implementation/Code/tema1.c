/** 
	Student: Barus Catalin-Stefan
	Group: 321CD
**/

#include <unistd.h>
#include <stdio.h> 
#include <stdarg.h>	
#include <string.h>
#include <stdlib.h>

/** Function used in converting negative binary integers to hexadecimal. **/
static char *convert_bin_to_hex(char * string)
{
	int i, k = 0;
	char *copy = (char*) calloc(1000000, sizeof(char));
	char *final_hex;
	
	for(i = 0; i < strlen(string); i += 4)
	{
		if(string[i] == '1' && string[i+1] == '1' && 
			string[i+2] == '1' && string[i+3] == '1')
		{
			copy[k] = 'f';
			k++;
		}

		if(string[i] == '1' && string[i+1] == '1' && 
			string[i+2] == '1' && string[i+3] == '0')
		{
				copy[k] = 'e';
				k++;
		}

		if(string[i] == '1' && string[i+1] == '1' && 
			string[i+2] == '0' && string[i+3] == '1')
		{
				copy[k] = 'd';
				k++;
		}

		if(string[i] == '1' && string[i+1] == '1' && 
			string[i+2] == '0' && string[i+3] == '0')
		{
				copy[k] = 'c';
				k++;
		}

		if(string[i] == '1' && string[i+1] == '0' && 
			string[i+2] == '1' && string[i+3] == '1')
		{
				copy[k] = 'b';
				k++;
		}

		if(string[i] == '1' && string[i+1] == '0' && 
			string[i+2] == '1' && string[i+3] == '0')
		{
				copy[k] = 'a';
				k++;
		}

		if(string[i] == '0' && string[i+1] == '0' && 
			string[i+2] == '0' && string[i+3] == '0')
		{
				copy[k] = '0';
				k++;
		}

		if(string[i] == '0' && string[i+1] == '0' && 
			string[i+2] == '0' && string[i+3] == '1')
		{
				copy[k] = '1';
				k++;
		}

		if(string[i] == '0' && string[i+1] == '0' && 
			string[i+2] == '1' && string[i+3] == '0')
		{
				copy[k] = '2';
				k++;
		}

		if(string[i] == '0' && string[i+1] == '0' && 
			string[i+2] == '1' && string[i+3] == '1')
		{
				copy[k] = '3';
				k++;
		}

		if(string[i] == '0' && string[i+1] == '1' && 
			string[i+2] == '0' && string[i+3] == '0')
		{
				copy[k] = '4';
				k++;
		}

		if(string[i] == '0' && string[i+1] == '1' && 
			string[i+2] == '0' && string[i+3] == '1')
		{
				copy[k] = '5';
				k++;
		}

		if(string[i] == '0' && string[i+1] == '1' && 
			string[i+2] == '1' && string[i+3] == '0')
		{
				copy[k] = '6';
				k++;
		}

		if(string[i] == '0' && string[i+1] == '1' && 
			string[i+2] == '1' && string[i+3] == '1')
		{
				copy[k] = '7';
				k++;
		}

		if(string[i] == '1' && string[i+1] == '0' && 
			string[i+2] == '0' && string[i+3] == '0')
		{
				copy[k] = '8';
				k++;
		}

		if(string[i] == '1' && string[i+1] == '0' && 
			string[i+2] == '0' && string[i+3] == '1')
		{
				copy[k] = '9';
				k++;
		}

	}

	final_hex = strdup(copy);
	return final_hex;
}

/** Function used in converting positive numbers in a given base. **/
static char *convert_to_string(long number, int wanted_base)
{
    char base_arrayidx[]="0123456789abcdef";
    int i=0, rest_index, j, k = 0;
    char *store = (char*) calloc(1000000, sizeof(char));
    char *clean = (char*) calloc(1000000, sizeof(char));
    
    while(number != 0)
    {
        rest_index = number % wanted_base;
        store[++i] = base_arrayidx[rest_index];
        number = number / wanted_base;
    }
   
    for(j=i; j>=0; j--)
    {
        clean[k] = store[j];
        k++;
    }

    char *converted;
    converted = strdup(clean);
    return converted;
}

/** Function used in converting an integer to a binary string. **/
char* convert_to_binarystring(int n)
{
	/* sizeof(long) used for displaying binary in 32 bit format */
	int i, b;
	char* binary = (char*) calloc(sizeof(long)*4-1, sizeof(char)); 
	
	for(i = sizeof(long)*4-1; i >= 0; i--)
	{
		b = (n & (1 << i))?1:0;

		if(b == 1)
			binary[sizeof(long)*4-1-i] = '1';
		else
			binary[sizeof(long)*4-1-i] = '0';
	}

	return binary;
}

static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}

int iocla_printf(const char *format, ...)
{
	/* TODO */

	const char *parameter;
	int number;
	long long_number;
	char *string;
	char *alphabet 
		= "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
	char *final = (char*) calloc(100000000, sizeof(char));
	char character;

	va_list args;
	va_start(args, format);

	for(parameter = format; *parameter != '\0'; parameter++)
	{
		/* Primary case of testing if we have a format specifier, by
		   checking if the read parameter is % . */
		if(*parameter == '%')
		{

			parameter++;

			/* Checking every required format specifier and adding the result 
			in a final string accordingly. */

			/* Each and every type of number is converted to char* in advance
			   to make sure we can use the write_stdout function. */

			if(*parameter == 's')
			{
				string = va_arg(args, char*);
				strncat(final, string, strlen(string));
			}
			else if(*parameter == 'd')
			{
				/* long is used to ensure that extra large integers
				   are analysed and displayed properly. */

				long_number = (int) va_arg(args, long);

				if(long_number < 0)
				{
					long_number = -long_number;
					char *minus = "-";
					string = convert_to_string(long_number, 10);

					/* destination is a placeholder string for getting 
					   around negative numbers when displaying them as char* */

					char *destination = (char*) calloc(10000000, sizeof(char));
					strncpy(destination, minus, 1);
					strcat(destination, string);
					strncat(final, destination, strlen(destination));
				}
				else
				{
					string = convert_to_string(long_number, 10);
					strncat(final, string, strlen(string));
				}
			}
			else if(*parameter == 'u')
			{
				/* long is used again to ensure that extra large integers
				   are analysed and displayed properly before casting them to 
				   unsigned int. */

				long_number = (unsigned int) va_arg(args, long);

				if(long_number < 0)
				{
					long_number = -long_number;
				}
				string = convert_to_string(long_number, 10);
				strncat(final, string, strlen(string));
			}
			else if(*parameter == 'x')
			{
				number = va_arg(args, int);

				if(number < 0)
				{
					/* The integer is first converted in binary and then
					   it is reconstructed in hexadecimal accordingly. */
					string = convert_to_binarystring(number);

					char *hex;
					hex = convert_bin_to_hex(string);
					strncat(final, hex, strlen(hex));
				}

				else
				{
					/* For positive numbers it is easier to convert the integer
					   straight to hexadecimal. */
					string = convert_to_string((long)number, 16);
					strncat(final ,string, strlen(string));
				}
			}
			else if(*parameter == 'c')
			{
				/* For characters coming from "%c" specifier it is easier to
				   just add the address of that character to final string. */

				number = va_arg(args, int);
				character = (char) number;
				strncat(final, &character, 1);
			}
			else if(*parameter == '%')
			{
				/* In case a "supposed" specifier is followed by another %. */
				strncat(final, "%", 1);
			}
		}

		/* Excluding the primary case, most important chars, including the 
		   numbers and all letters are also tested and added to the final 
		   string, if they were written besides variables/values/specifiers. */

		else if(*parameter == ' ')
		{
			strncat(final, " ", 1);
		}
		else if(*parameter == '\n')
		{
			strncat(final, "\n", 1);
		}
		else if(*parameter == '\t')
		{
			strncat(final, "\t", 1);
		}
		else if(strchr(alphabet, *parameter) != NULL)
		{
			strncat(final, parameter, 1);
		}
		else if(strchr("!?.',<>@#$^&*()[]{}-_+=~", *parameter) != NULL)
		{
			strncat(final, parameter, 1);
		}
		if(*parameter == (char) 92) // ASCII representation of the charcter '\'
		{	
			strncat(final, parameter, 1);
		}
	}
	
	va_end(args);


	/* At the end the string final will contain all data to be be printed. */
	return write_stdout(final, strlen(final));
}
