# Sanitarium - CCR HPC Test Suite

Sanitarium is a test suite for automated acceptance testing of CCR's HPC
clusters. These are used to sanity check clusters after downtimes along with
helping assess changes and upgrades to the Slurm scheduler. All tests are
written for [Pavilion2](https://github.com/hpc/pavilion2) and assume you're
using CCR's software infrastructure which includes pavilion as a module.

For documenation on writing tests see [here](https://pavilion2.readthedocs.io/en/latest/).

## Initial Setup

1. Create working directory for pavilion test output:

```
$ mkdir -p $HOME/testsuite/working_dir
```

2. [Fork this repo](https://github.com/ubccr/sanitarium/fork)


3. Clone your fork into $HOME/testsuite:

```
$ cd $HOME/testsuite
$ git clone git@github.com:YOURUSER/sanitarium.git
$ git remote add upstream git@github.com:ubccr/sanitarium.git
```

3. Check that everything works:

```
$ module load gcc pavilion
$ pav show tests
 Available Tests                                                                
-----------------+-------------------------------------------------------------
 Name            | Summary                                                     
-----------------+-------------------------------------------------------------
 gpu.nvhpc       | A basic GPU test. Uses NVHPC module to run vector_add       
 mpi.intelmpi    | A basic Intel MPI test.                                     
 mpi.intelpong   | Intel MPI PingPong test.                                    
 mpi.openmpi     | A basic OpenMPI test. Uses openmpi module to run supermagic 
 sanity.jobarray | Test for Slurm job array support                            
 sanity.scratch  | Test reading/writing to scratch   
```

## Example usage

### Run all tests

```
$ pav run -f ccr-test-suite
Resolving Test Configs: 100%
Creating Test Runs: 100%
Building 6 tests for test set cmd_line.
BUILD_REUSED: 6

$ pav status
 Test statuses                                                                                
------+-----------------+-----------------+-------+-----------------+----------+--------+----------
 Test | Job id          | Name            | Nodes | Part            | State    | Result | Updated  
------+-----------------+-----------------+-------+-----------------+----------+--------+----------
 132  | 2675_cld-squall | mpi.openmpi     | 2     | general-compute | COMPLETE | PASS   | 15:54:31 
 131  | 2674_cld-squall | mpi.intelpong   | 2     | general-compute | COMPLETE | PASS   | 15:54:31 
 130  | 2673_cld-squall | mpi.intelmpi    | 2     | general-compute | COMPLETE | PASS   | 15:54:30 
 129  | 2672_cld-squall | gpu.nvhpc       | 1     | general-compute | COMPLETE | PASS   | 15:54:28 
 128  | 2671_cld-squall | sanity.jobarray | 1     | general-compute | COMPLETE | PASS   | 15:54:58 
 127  | 2670_cld-squall | sanity.scratch  | 1     | general-compute | COMPLETE | PASS   | 15:54:58 
```

### Run single test

```
$ pav run gpu.nvhpc
```

### Check job output of test number 101

```
$ pav log run 101

# The above command just looks at this file
$ cat $HOME/testsuite/working_dir/test_runs/101/run.log

# All interesting files are located in the test_runs dir:
$ ls $HOME/testsuite/working_dir/test_runs/101
```

### Get detailed results of a test run

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

## Manual Installation

Read the docs for installing pavilion [here](https://pavilion2.readthedocs.io/en/latest/install.html)

## License

GNU General Public License v3.0. See LICENSE file.
