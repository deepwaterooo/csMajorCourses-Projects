int sampleSize = 10;
float mutateRate = 0.5;
float crsRate = 0.9;
int* idxArray = new int[sampleSize];

int popuSize[8] = {20, 25, 50, 100, 200, 400, 800, 1000};
int genCount[8] = {1000, 800, 400, 200, 100, 50, 25, 20};
float minFitness[8];
float avgFitness[8];

int counter = 0;
twoIdx winIdx;
float min, avg;
     
for (int it = 0; it < 8; ++it) {     
    min = 0.0;
    avg = 0.0;
    for (int i = 0; i < 1000; ++i) {         
        Population* popu = new Population(popuSize[it], mutateRate, crsRate, indi);
        counter = 0;
        while (counter < genCount[it]) {
            popu->genRanIndi(sampleSize);
            idxArray = popu->idxArray;
            winIdx = popu->tourSelection(sampleSize);
            popu->newGen(winIdx, counter);
            ++counter;
        }
        min += popu->minFitness();
        avg += popu->avgFitness();
    }
    minFitness[it] = min / 1000.0;
    avgFitness[it] = avg / 1000.0;
 }

for (int i = 0; i < 8; ++i) 
    printf("%5.5f\t %5.5f\n", minFitness[i], avgFitness[i]);
