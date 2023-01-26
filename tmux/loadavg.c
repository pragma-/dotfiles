#include <fcntl.h>
#include <unistd.h>

int main(void) {
  // the sleep(5) here seems to override tmux's status-interval
  for (char b[64], n, a = open("/proc/loadavg", O_RDONLY); ; sleep(5))
    if ((n = read(a, b, sizeof b)) > 0) lseek(a, 0, SEEK_SET), write(1, b, n);
}
