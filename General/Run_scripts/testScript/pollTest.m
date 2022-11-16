repeats = 10;

% D = parallel.pool.PollableDataQueue;
bar = PoolWaitbar(repeats);
q = parallel.pool.DataQueue;
afterEach(q, @(value)bar.updateBarValue(value));


parfor n=1:repeats
    pause(2);
    send(q, 1/n);
end

