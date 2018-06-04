#include <am.h>
#include <benchmark.h>
#include <trap.h>
#include <limits.h>

volatile unsigned int* cnt0=(void*) 0x40020000;
volatile unsigned int* cnt1=(void*) 0x40020008;
volatile unsigned int* cnt2=(void*) 0x40021000;
volatile unsigned int* cnt3=(void*) 0x40021008;
volatile unsigned int* cnt4=(void*) 0x40022000;
volatile unsigned int* cnt5=(void*) 0x40022008;
volatile unsigned int* cnt6=(void*) 0x40023000;
volatile unsigned int* cnt7=(void*) 0x40023008;
volatile unsigned int* cnt8=(void*) 0x40024000;
volatile unsigned int* cnt9=(void*) 0x40024008;
volatile unsigned int* cnt10=(void*) 0x40025000;
volatile unsigned int* cnt11=(void*) 0x40025008;
volatile unsigned int* cnt12=(void*) 0x40026000;
volatile unsigned int* cnt13=(void*) 0x40026008;
volatile unsigned int* cnt14=(void*) 0x40027000;
volatile unsigned int* cnt15=(void*) 0x40027008;


typedef struct Result {
  int pass;
  unsigned long msec;
  //-----------------
  unsigned long Clkcount;
  unsigned long Fetchcount;
  unsigned long Fwaitcount;
  unsigned long Lmemcount;
  unsigned long Lwaitcount;
  unsigned long Smemcount;
  unsigned long Inscount;
  unsigned long Jcount;
  unsigned long Bcount;
  unsigned long Rcount;
  unsigned long Lcount;
  unsigned long Scount;
  unsigned long Icount;
} Result;

unsigned long _uptime() {
  //   You can use this function to access performance counter related with time or cycle.
  return *(cnt0);

  return 0;
}

static void bench_prepare(Result *res) {
  //   Add preprocess code, record performance counters' initial states.
  //   You can communicate between bench_prepare() and bench_done() through
  //   static variables or add additional fields in `struct Result`
  
  res->msec = _uptime();
}

static void bench_done(Result *res) {
  //  Add postprocess code, record performance counters' current states.
  res->Clkcount = *(unsigned int*)(cnt0);
  res->Fetchcount = *(unsigned int*)(cnt1);
  res->Fwaitcount = *(unsigned int*)(cnt2);
  res->Lmemcount = *(unsigned int*)(cnt3);
  res->Lwaitcount = *(unsigned int*)(cnt4);
  res->Smemcount = *(unsigned int*)(cnt5);
  res->Inscount = *(unsigned int*)(cnt6);
  res->Jcount = *(unsigned int*)(cnt7);
  res->Bcount = *(unsigned int*)(cnt8);
  res->Rcount = *(unsigned int*)(cnt9);
  res->Lcount = *(unsigned int*)(cnt10);
  res->Scount = *(unsigned int*)(cnt11);
  res->Icount = *(unsigned int*)(cnt12);
  res->msec = _uptime() - res->msec;
}


Benchmark *current;
Setting *setting;

static char *start;

#define ARR_SIZE(a) (sizeof((a)) / sizeof((a)[0]))

// The benchmark list

#define ENTRY(_name, _sname, _s1, _s2, _desc) \
  { .prepare = bench_##_name##_prepare, \
    .run = bench_##_name##_run, \
    .validate = bench_##_name##_validate, \
    .name = _sname, \
    .desc = _desc, \
    .settings = {_s1, _s2}, },

Benchmark benchmarks[] = {
  BENCHMARK_LIST(ENTRY)
};

extern char _heap_start[];
extern char _heap_end[];
_Area _heap = {
  .start = _heap_start,
  .end = _heap_end,
};

static const char *bench_check(Benchmark *bench) {
  unsigned long freesp = (unsigned long)_heap.end - (unsigned long)_heap.start;
  if (freesp < setting->mlim) {
    return "(insufficient memory)";
  }
  return NULL;
}

void run_once(Benchmark *b, Result *res) {
  bench_reset();       // reset malloc state
  current->prepare();  // call bechmark's prepare function
  bench_prepare(res);  // clean everything, start timer
  current->run();      // run it
  bench_done(res);     // collect results
  res->pass = current->validate();
}

int main() {
  int pass = 1;

  _Static_assert(ARR_SIZE(benchmarks) > 0, "non benchmark");

  for (int i = 0; i < ARR_SIZE(benchmarks); i ++) {
    Benchmark *bench = &benchmarks[i];
    current = bench;
    setting = &bench->settings[SETTING];
    const char *msg = bench_check(bench);
    printk("[%s] %s: ", bench->name, bench->desc);
    if (msg != NULL) {
      printk("Ignored %s\n", msg);
    } else {
      unsigned long msec = ULONG_MAX;
      int succ = 1;
      for (int i = 0; i < REPEAT; i ++) {
        Result res;
        run_once(bench, &res);
        printk(res.pass ? "*" : "X");
        succ &= res.pass;
        if (res.msec < msec) msec = res.msec;
        printk("Clkcount = %u\n",res.Clkcount);
        printk("Fetchcount = %u\n",res.Fetchcount);
        printk("Fwaitcount = %u\n",res.Fwaitcount);
        printk("Lmemcount = %u\n",res.Lmemcount);
        printk("Lwaitcount = %u\n",res.Lwaitcount);
        printk("Smemcount = %u\n",res.Smemcount);
        printk("Inscount = %u\n",res.Inscount);
        printk("Jcount = %u\n",res.Jcount);
        printk("Bcount = %u\n",res.Bcount);
        printk("Rcount = %u\n",res.Rcount);
        printk("Lcount = %u\n",res.Lcount);
        printk("Scount = %u\n",res.Scount);
        printk("Icount = %u\n",res.Icount);
      }

      if (succ) printk(" Passed.\n");
      else printk(" Failed.\n");

      pass &= succ;

      //   A benchmark is finished here, you can use printk to output some informantion.
      //   `msec' is intended indicate the time (or cycle),
      //   you can ignore according to your performance counters semantics.
    }
  }

  hit_good_trap();
  return 0;
}

// Library


void* bench_alloc(size_t size) {
  if ((uintptr_t)start % 16 != 0) {
    start = start + 16 - ((uintptr_t)start % 16);
  }
  char *old = start;
  start += size;
  assert((uintptr_t)_heap.start <= (uintptr_t)start && (uintptr_t)start < (uintptr_t)_heap.end);
  for (char *p = old; p != start; p ++) *p = '\0';
  assert((uintptr_t)start - (uintptr_t)_heap.start <= setting->mlim);
  return old;
}

void bench_free(void *ptr) {
}

void bench_reset() {
  start = (char*)_heap.start;
}

static int32_t seed = 1;

void bench_srand(int32_t _seed) {
  seed = _seed & 0x7fff;
}

int32_t bench_rand() {
  seed = (mmul_u(seed , (int32_t)214013L) + (int32_t)2531011L);
  return (seed >> 16) & 0x7fff;
}

// FNV hash
uint32_t checksum(void *start, void *end) {
  const int32_t x = 16777619;
  int32_t hash = 2166136261u;
  for (uint8_t *p = (uint8_t*)start; p + 4 < (uint8_t*)end; p += 4) {
    int32_t h1 = hash;
    for (int i = 0; i < 4; i ++) {
      h1 = mmul_u((h1 ^ p[i]) , x);
    }
    hash = h1;
  }
  hash += hash << 13;
  hash ^= hash >> 7;
  hash += hash << 3;
  hash ^= hash >> 17;
  hash += hash << 5;
  return hash;
}

