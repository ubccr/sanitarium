# Sanitarium - CCR HPC Test Suite

Sanitarium is a test suite for automated acceptance testing of CCR's HPC
clusters. These are used to sanity check clusters after downtimes along with
helping assess changes and upgrades to the Slurm scheduler. All tests are
written for [Pavilion2](https://github.com/hpc/pavilion2)

For documenation on writing tests see [here](https://pavilion2.readthedocs.io/en/latest/).

## Requirements

- Python 3.6 
- Pavilion2 (ccrdev branch [here](https://github.com/ubccr/pavilion2/tree/ccrdev)) 

# Install Pavilion2

```
$ yum install python3
$ git clone https://github.com/ubccr/pavilion2.git
$ cd pavilion2
$ git checkout ccrdev
$ git submodule update --init --recursive
```

# Checkout CCR HPC Test Suite

```
$ git clone git@github.com:ubccr/sanitarium.git
```

## Configuration

Per host configs live in the `hosts` directory. This is where you can set
global variables for all tests. So things like partition, reservation, etc.
without having to duplicate them for each test. For the test cluster, all
settings live in `cld-huey.yaml`. For production, this will likely be
`vortex1.yaml`. We can also set up "mode" configs for prod and dev "modes". See
[here](https://pavilion2.readthedocs.io/en/latest/basics.html#host-configs) for
more information.

## Running tests

Login to front end and setup environment. Need to setup your `PATH` to include
`pavilion2/bin` and set `PAV_CONFIG_DIR` to the location of sanitarium:

```
$ ssh huey
$ export PAV_CONFIG_DIR=/PATH/TO/sanitarium
$ export PATH=/PATH/TO/pavilion2/bin:$PATH
```

## Show all available tests

```
$ pav show tests
 Available Tests                                                            
-----------------+---------------------------------------------------------
 Name            | Summary                                                 
-----------------+---------------------------------------------------------
 sanity.jobarray | Test for Slurm job array support                        
 sanity.mpi      | A basic MPI test. Uses openmpi module to run supermagic 
```

## Run all sanity tests

```
$ pav run sanity
BUILD_REUSED: 2                   
2 tests started as test series s20.

$ pav results
 Test Results                  
-----------------+----+--------
 Name            | Id | Result 
-----------------+----+--------
 sanity.jobarray | 22 | PASS   
 sanity.mpi      | 23 | PASS
```

## Get detailed results of a test run

```
pav results -f 22
[{'created': '2020-05-16 20:00:09.919283',
  'duration': '0:00:00.169232',
  'finished': '2020-05-16 20:00:09.975418',
  'fn': {'array_395-1.out': {'slurm_array_task_id': '1'},
         'array_395-2.out': {'slurm_array_task_id': '2'},
         'array_395-3.out': {'slurm_array_task_id': '3'},
         'array_395-4.out': {'slurm_array_task_id': '4'},
         'array_395-5.out': {'slurm_array_task_id': '5'}},
  'id': 22,
  'job_id': '395',
  'name': 'sanity.jobarray',
  'pav_result_errors': [],
  'result': 'PASS',
  'sched': {'alloc_cpu_total': ['8'],
            'alloc_max_mem': ['23000'],
            'alloc_max_ppn': ['8'],
            'alloc_min_mem': ['23000'],
            'alloc_min_ppn': ['8'],
            'alloc_node_list': ['cpn-d13-16'],
            'alloc_nodes': ['1'],
            'max_mem': ['23000'],
            'max_ppn': ['8'],
            'min_mem': ['23000'],
            'min_ppn': ['8'],
            'nodes': ['16'],
            'nodes_avail': ['11'],
            'nodes_up': ['11'],
            'test_cmd': ['srun -N 1 -n 1'],
            'test_node_list': ['cpn-d13-16'],
            'test_nodes': ['1'],
            'test_procs': ['1']},
  'started': '2020-05-16 20:00:09.806186',
  'sys_name': 'cld-huey',
  'user': 'testsuite'}]
```
