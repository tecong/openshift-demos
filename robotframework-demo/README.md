# Robot framework demo 

A Ubuntu based container for running selenium tests with Chrome using Xvfb.
Container needs a volume to be mapped where the testcases are found and the results are stored.

## Environment variables that control the robot execution

* LOG_LEVEL
  * defines the logging level of robot framework
  * valid levels are TRACE, DEBUG, INFO (default), HTML, WARN, and ERROR 
* RES
  * resolution of the Xvfb display, default is 1280x1024x24
* DISPLAY
  * display identifier, default is :99
* ROBOT_TESTS
  * robot test file(s), all tests within a file(s) are executed
* ROBOT_OUTPUT_DIRECTORY
  * directory where results of the test are stored

## Running container

build the container:
    
    docker build -t robotframework-demo .

run the container:

    docker run  -v <local directory to be mounted>:<destibation directory in container> --env ROBOT_OUTPUT_DIRECTORY=<destibation directory in container>/results --env ROBOT_TESTS=<destibation directory in container>/*.robot --security-opt seccomp=chrome.json robotframework-demo

example:

    docker run  -v /home/robottester/tests:/robot --env ROBOT_OUTPUT_DIRECTORY=/robot/results --env ROBOT_TESTS=/robot/testcases.robot --security-opt seccomp=chrome.json robotframework-demo