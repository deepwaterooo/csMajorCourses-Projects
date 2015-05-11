vf hcsch(vf point) {
    vf currentPoint = point;     // the zero-magnitude vector is common
    bestScore = INF;
    float stepSize[30] = { 1.1, 1.1, 1.1, 1.1,1.1, 1.1, 1.1, 1.1, 1.1, 1.1,1.1, 1.1, 1.1, 1.1, 1.1,  
                           1.1, 1.1, 1.1, 1.1,1.1, 1.1, 1.1, 1.1, 1.1,1.1,1.1,1.1,1.1,1.1,1.1 };    
    float acceleration = 2.5;
    float temp;
    float before = getsch(currentPoint);
    int besti, bestj, curri, currj;
    float xi, si;
    float candidate[5];
    vf sschange, ssfive;
    vvf once;
    for (int i = 0; i < 30; ++i)
	sschange.push_back(0);
    for (int x = 0; x < 100; ++x) {
	candidate[0] = -acceleration;
	candidate[1] = -0.5 * acceleration;
	candidate[2] = 0;
	candidate[3] = .5 * acceleration;
	candidate[4] = acceleration;
	besti = -1;
	curri = -1;
	before = getsch(currentPoint);
	for (int i = 0; i < 30; ++i){     //for each element i in currentPoint do
	    bestj = -1;
	    for (int j = 0; j < 5; ++j) {  // try each of 5 candidate locations
		currj = -1;
		currentPoint[i] = currentPoint[i] + stepSize[i]*candidate[j];
		if (currentPoint[i] < schl || currentPoint[i] > schh) 
		    continue;
		temp = getsch(currentPoint);
		if(temp < bestScore) {
		    bestScore = temp;
		    vbest = currentPoint;
		    bestj = j;
		} 
		if (temp < before) {
		    before = temp;
		    currj = j;
		    vcurrj = currentPoint;
		}
		currentPoint[i] = currentPoint[i] - stepSize[i]*candidate[j];
	    } // j
	    if ( (currj != -1) && (candidate[currj] != 0) ) {
		currentPoint = vcurrj;
		sschange[i] = stepSize[i] * candidate[currj];   // record the ith change
		curri = i;
	    }
	    if (bestj != -1) {
		besti = i;
	    }
	    once.push_back(currentPoint);
	    currentPoint = point;
	} // i
	if (curri != -1) {
	    currentPoint = once[curri];
	    stepSize[curri] = sschange[curri];
	    printf("x: %d; i: %d; y: %5.4f\n", x, curri, bestScore);
	}
	for (int i = 0; i < 30; ++i) {
	    sschange[i] = 0;
	    once.pop_back();
	}
    }  // x
    return vbest;
} 
