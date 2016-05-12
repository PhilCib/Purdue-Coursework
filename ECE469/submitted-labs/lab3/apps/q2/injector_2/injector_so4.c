//#include "lab2-api.h"
#include "usertraps.h"
#include "misc.h"
//#include "prod_cons.h"

void main(int argc, char * argv[])
{
 
  
  sem_t s_procs_completed; // Semaphore to signal the original process that we're done 
  char * msg = NULL;
  mbox_t h_mbox;
  //Printf("Are we in injector1...\n");
  if (argc != 3){
    Printf("\nmust pass two arguments\n");
    Exit();
  }
  s_procs_completed = dstrtol(argv[2], NULL, 10);//Printf("31\n");
  //just send it through a mailbox
  h_mbox = dstrtol(argv[1], NULL, 10); // The "10" means base 10
  *(msg) = 'A'; //the dummy message to be sent
  
  if (mbox_send(h_mbox, sizeof(msg), (void *) msg) == MBOX_FAIL) {
      Printf("\nCould not send message to mailbox %d in (%d)\n", h_mbox, getpid());
      Exit();
    }
  Printf("\nSO4 was injected.\n");
  //Printf("are we in injector 2...\n");
  
  //Printf("\ninjector_2 is terminated.\n");


  if(sem_signal(s_procs_completed) != SYNC_SUCCESS) {
    Printf("Bad semaphore s_procs_completed (%d) in ", s_procs_completed); Printf(argv[0]); Printf(", exiting...\n");
    Exit();
  }

}