.PHONY: clean

PLATFORM_PATH = /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.0.sdk
FRAMEWORK_PATH = $(PLATFORM_PATH)/System/Library/Frameworks
PRIVATE_FRAMEWORK_PATH = $(PLATFORM_PATH)/System/Library/Frameworks

ALL_HEADERS = Headers/SpringBoard Headers/UIKit

CLASS_DUMP_FLAGS = -h proto -h super -R -b -X CF,NS -y $(PLATFORM_PATH)

all : $(ALL_HEADERS)

class-dump-z :
	curl http://rpetri.ch/uploads/class-dump-z.tar.gz | tar -xz class-dump-z

Headers/% : class-dump-z Headers Hints_out.txt
	rm -rf $@
	./class-dump-z $(CLASS_DUMP_FLAGS) -i Hints_out.txt -H -o $@ $(filter $(PLATFORM_PATH)/%,$^)

Headers :
	mkdir Headers

Hints_out.txt : Hints.txt
	cp -f Hints.txt Hints_out.txt	

clean :
	rm -rf $(ALL_HEADERS) Hints_out.txt

Headers/SpringBoard : $(PLATFORM_PATH)/System/Library/CoreServices/SpringBoard.app/SpringBoard

Headers/UIKit : $(FRAMEWORK_PATH)/UIKit.framework/UIKit

