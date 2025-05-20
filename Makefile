# ---------------------------------------
# Compiler and Flags
# ---------------------------------------
CXX       := g++
CXXFLAGS  := -Wall -std=c++17 \
              -I. \
              -Icore \
              -Inetwork \
              -Imodels \
              -Iutils \
              


# ---------------------------------------
# Linker Flags and Libraries
# ---------------------------------------
LIBDIRS   := -LC:/msys64/mingw64/lib 



LDLIBS    :=  -lfmt \
              -lssl \
              -lcrypto \
              -lws2_32 \
              -lmswsock

# ---------------------------------------
# Source and Object Files
# ---------------------------------------
SRCDIRS   := . core network models utils
SRC       := $(wildcard main.cpp $(foreach d,$(SRCDIRS),$(d)/*.cpp))
OBJ       := $(SRC:.cpp=.o)

# ---------------------------------------
# Output Executable
# ---------------------------------------
TARGET    := TradeSim.exe

# ---------------------------------------
# Build Rules
# ---------------------------------------
.PHONY: all clean

all: $(TARGET)

# $(TARGET): $(OBJ)
# 	$(CXX) $(CXXFLAGS) $(OBJ) -o $@ $(LIBDIRS) $(LDLIBS)

$(TARGET): $(OBJ)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LIBDIRS) $(LDLIBS)


%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

clean:
	-@rm -f $(OBJ) $(TARGET)
