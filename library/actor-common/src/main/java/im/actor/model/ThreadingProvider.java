/*
 * Copyright (C) 2015 Actor LLC. <https://actor.im>
 */

package im.actor.model;

import im.actor.model.droidkit.actors.ActorSystem;
import im.actor.model.droidkit.actors.ThreadPriority;
import im.actor.model.droidkit.actors.mailbox.ActorDispatcher;
import im.actor.model.util.AtomicIntegerCompat;
import im.actor.model.util.AtomicLongCompat;
import im.actor.model.util.ThreadLocalCompat;

/**
 * Provider for multithreading support. Contains all required methods for performing asynchronous operations.
 */
public interface ThreadingProvider {

    /**
     * Time in ms from some fixed point in time and that not relied to local time changes.
     *
     * @return time in ms
     */
    long getActorTime();

    /**
     * Current unix-time of system
     *
     * @return time in ms
     */
    long getCurrentTime();

    /**
     * Synchronized time by NTP. Used for more accurate timing of messages.
     * Return value from getCurrentTime() if not supported.
     *
     * @return time in ms
     */
    long getSyncedCurrentTime();

    /**
     * Number of computing cores in environment
     *
     * @return cores count
     */
    int getCoresCount();

    /**
     * Creating compatable AtomicInteger object
     *
     * @param value initial value of AtomicInteger
     * @return the AtomicInteger
     */
    AtomicIntegerCompat createAtomicInt(int value);

    /**
     * Creating compatable AtomicLong object
     *
     * @param value initial value of AtomicLong
     * @return the AtomicLong
     */
    AtomicLongCompat createAtomicLong(long value);

    /**
     * Creating compatable ThreadLocal object
     *
     * @param <T> type of container
     * @return the ThreadLocal object
     */
    <T> ThreadLocalCompat<T> createThreadLocal();

    /**
     * Creating of Actor Dispatcher for dispatching of actor's Envelopes
     *
     * @param name         name of dispatcher
     * @param threadsCount desired thread count
     * @param priority     priority of dispatcher
     * @param actorSystem  ActorSystem for dispatcher
     * @return created dispatcher
     */
    ActorDispatcher createDispatcher(String name, int threadsCount, ThreadPriority priority, ActorSystem actorSystem);

    /**
     * Creating dispatcher with default configuration
     *
     * @param name     name of dispatcher
     * @param priority priority of dispatcher
     * @param system   ActorSystem of dispatcher
     * @return created dispatcher
     */
    ActorDispatcher createDefaultDispatcher(String name, ThreadPriority priority, ActorSystem system);
}