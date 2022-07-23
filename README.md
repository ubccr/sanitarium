# Sanitarium - CCR HPC Test Suite

Sanitarium is a test suite for automated acceptance testing of CCR's HPC
clusters. These are used to sanity check clusters after downtimes along with
helping assess changes and upgrades to the Slurm scheduler. All tests are
written for [Pavilion2](https://github.com/hpc/pavilion2)

For documenation on writing tests see [here](https://pavilion2.readthedocs.io/en/latest/).

## Requirements

- Python 3.6 
- Pavilion2

Install Pavilion2

Follow docs for installing pavilion [here](https://pavilion2.readthedocs.io/en/latest/install.html)

Checkout CCR HPC Test Suite

```
$ git clone git@github.com:ubccr/sanitarium.git
$ cd sanitarium
```

## Running tests

Login to front end and setup environment. Need to setup your `PATH` to include
`pavilion2/bin` and set `PAV_CONFIG_DIR` to the location of sanitarium:

```
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
 sanity.gpu      | A basic GPU test. Uses CUDA module to run vector_add
 sanity.intelmpi | A basic Intel MPI test.
 sanity.jobarray | Test for Slurm job array support
 sanity.mpi      | A basic MPI test. Uses openmpi module to run supermagic
 sanity.scratch  | Test reading/writing to scratch
```

## Run all sanity tests

```
$ pav run -m dev sanity
BUILD_REUSED: 2                   
2 tests started as test series s20.

$ pav status
 Test statuses                                                                   
------+---------------------+-----------------+-------+----------+--------+----------
 Test | Job id              | Name            | Nodes | State    | Result | Time     
------+---------------------+-----------------+-------+----------+--------+----------
 10   | job_2530_cld-squall | sanity.gpu      | 1     | COMPLETE | PASS   | 16:52:51 
 9    | job_2527_cld-squall | sanity.intelmpi | 2     | COMPLETE | PASS   | 16:52:52 
 8    | job_2527_cld-squall | sanity.mpi      | 2     | COMPLETE | PASS   | 16:52:44 
 7    | job_2529_cld-squall | sanity.jobarray | 1     | COMPLETE | PASS   | 16:53:11 
 6    | job_2528_cld-squall | sanity.scratch  | 1     | COMPLETE | PASS   | 16:53:11
```

## Get detailed results of a test run

```
pav results -f 10
[{'created': 1658609552.9155178,
  'duration': 10.485295057296753,
  'finish_date': '2022/07/23 16:52:51',
  'finished': 1658609571.0483806,
  'id': 10,
  'job_info': {'id': '2530', 'sys_name': 'cld-squall'},
  'name': 'sanity.gpu',
  'pav_result_errors': [],
  'pav_version': '2.4',
  'per_file': {},
  'permute_on': {},
  'result': 'PASS',
  'results_log': '/user/testsuite/pavwork/src/working_dir/test_runs/10/results.log',
  'return_value': 0,
  'sched': {'chunk_ids': '0',
            'errors': None,
            'min_cpus': '6',
            'min_mem': '0.019073486328125',
            'node_list_id': '0',
            'nodes': '9',
            'tasks_per_node': '1',
            'tasks_total': '1',
            'test_cmd': 'srun -N 1 -w cpn-m11-18 -n 1',
            'test_min_cpus': '8',
            'test_min_mem': '0.2384185791015625',
            'test_nodes': '1'},
  'started': 1658609560.5630856,
  'sys_name': 'cld-squall',
  'test_version': '0.0',
  'user': 'testsuite',
  'uuid': 'e4743e21-fe76-4545-acbf-1f6b7e63ddc1'}]
```
