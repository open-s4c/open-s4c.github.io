S4C is home to a set of concurrency projects targeting system software.

## Projects

Currently we host 3 projects:

- **[libvsync](/libvsync)**:
libvsync is a C header-only library that contains most essential building blocks for concurrent applications,
including atomic operations, synchronization primitives and concurrent data structures.
The library has been verified and optimized for Weak Memory Models (WMMs) such as in Arm CPUs.

- **[vsyncer]**: is a toolkit to verify and optimize concurrent C/C++ programs on WMMs,
which employs state-of-the-art model checkers [Dartagnan][] and [GenMC][].

- **[benchkit]**: A framework to support the development of reproducible benchmarks.

[vsyncer]: https://github.com/open-s4c/vsyncer
[benchkit]: https://github.com/open-s4c/benchkit

## Publications

- [VSync: push-button verification and optimization for synchronization primitives on weak memory models](https://dl.acm.org/doi/10.1145/3445814.3446748) --- ASPLOS'21, Oberhauser et al.
- [Verifying and Optimizing the HMCS Lock for Arm Servers](https://link.springer.com/chapter/10.1007/978-3-030-91014-3_17) --- NETYS'21, Oberhauser et al.
- [Verifying and Optimizing Compact NUMA-Aware Locks on Weak Memory Models](https://arxiv.org/abs/2111.15240) --- Technical report, 2022, Paolillo et al.
- [CLoF: A Compositional Lock Framework for Multi-level NUMA Systems](https://dl.acm.org/doi/10.1145/3477132.3483557) --- SOSP'22, Chehab et al.
- [BBQ: A Block-based Bounded Queue for Exchanging Data and Profiling](https://www.usenix.org/conference/atc22/presentation/wang-jiawei) --- ATC'22, Wang et al.
- [BWoS: Formally Verified Block-based Work Stealing for Parallel Processing](https://www.usenix.org/conference/osdi23/presentation/wang-jiawei) --- OSDI'23, Wang et al.
- [AtoMig: Automatically Migrating Millions Lines of Code from TSO to WMM](https://dl.acm.org/doi/abs/10.1145/3575693.3579849) --- ASPLOS'23, Beck et al.


[publication]: https://dl.acm.org/doi/abs/10.1145/3445814.3446748
[Dartagnan]: https://github.com/hernanponcedeleon/Dat3M
[GenMC]: https://github.com/MPI-SWS/genmc

